/*
Copyright (c) Lyo Kato (lyo.kato _at_ gmail.com)

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION 
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
*/

package org.coderepos.sasl.mechanisms
{
    import flash.utils.ByteArray;

    import org.coderepos.sasl.exceptions.SASLBadChallengeError;
    import org.coderepos.sasl.SASLConfig;

    import com.hurlant.util.Hex;
    import com.hurlant.crypto.Crypto;
    import com.hurlant.crypto.hash.IHash;

    // RFC2831
    public class DIGEST_MD5 implements ISASLMechanism
    {
        private var _config:SASLConfig;
        private var _step:uint;
        private var _debugCNonce:String;

        public function DIGEST_MD5(config:SASLConfig)
        {
            _config = config;
        }

        public function set debugCNonce(str:String):void
        {
            _debugCNonce = str;
        }

        private function reset():void
        {
            _step = 0;

            //_nonce = null;
            //_realm = null;
        }

        public function get name():String
        {
            return "DIGEST-MD5";
        }

        public function start():String
        {
            reset();
            return "";
        }

        public function step(challenge:String):String
        {
            var req:Object = parseChallenge(challenge);
            var result:String;
            if (_step == 0) {
                if (!("algorithm" in req)) {
                    throw new SASLBadChallengeError("'algorithm' not found");
                }
                if (!("nonce" in req)) {
                    throw new SASLBadChallengeError("'nonce' not found");
                }
                var res:Object    = {};
                res['nonce']      = req['nonce'];
                res['cnonce']     = (_debugCNonce != null) ? _debugCNonce : genNonce();
                // FIXME: server realm may be multiple
                res['digest-uri'] = _config.service + "/" + req['realm'];
                res['charset']    = 'utf-8';
                res['nc']         = '00000001';
                // FIXME: check server qop
                res['qop']        = 'auth';
                // FIXME: server realm may be multiple
                res['realm']      = ("realm" in req) ? req['realm'] : _config.host;
                if (_config.authzid != null && _config.authzid.length > 0)
                    res['authzid'] = _config.authzid;
                if (_config.username != null)
                    res['username'] = _config.username;
                res['response']   = genResponseValue(res);

                var params:Array = [];
                for (var prop:String in res) {
                    var val:String = res[prop];
                    if (!(prop == "nc" || prop == "qop" || prop == "response" || prop == "charset"))
                        val = '"' + val + '"';
                    params.push(prop + "=" + val);
                }
                result = params.join(',');
                _step = 1;
            } else if(_step == 1) {
                /* TODO: chech the challenge from server
                if (!("rspauth" in req && req['rspauth'] == _rspauth)) {
                    throw new SASLBadChallengeError("Bad Challenge: " + challenge);
                }
                */
                result = "";
            }
            return result;
        }

        public function genResponseValue(res:Object):String
        {
            var password:String = (_config.password != null)
                ? _config.password : "";

            var hasher:IHash = Crypto.getHash("md5");
            var a1Src:ByteArray = new ByteArray();
            a1Src.writeUTFBytes(res['username'] + ":" + res['realm'] + ":" + password);
            var a1:ByteArray = hasher.hash(a1Src);
            a1.position = a1.length;
            a1.writeUTFBytes(":" + res['nonce'] + ":" + res['cnonce']);
            if ("authzid" in res)
                a1.writeUTFBytes(":" + res['authzid']);
            var a1hh:String = Hex.fromArray(hasher.hash(a1));
            var a2:ByteArray = new ByteArray();
            a2.writeUTFBytes("AUTHENTICATE:" + res['digest-uri']);
            if (res['qop'] != 'auth')
                a2.writeUTFBytes(":00000000000000000000000000000000");
            var a2hh:String = Hex.fromArray(hasher.hash(a2));

            var result:ByteArray = new ByteArray();
            result.writeUTFBytes(a1hh + ':' + res['nonce'] + ":00000001:"
                + res['cnonce'] + ':' + res['qop'] + ':' + a2hh);
            return Hex.fromArray(hasher.hash(result));
        }

        public function genNonce():String
        {
            var hasher:IHash = Crypto.getHash("md5");
            var b:ByteArray = new ByteArray();
            b.writeUTFBytes(String((new Date()).time));
            return Hex.fromArray(hasher.hash(b));
        }

        public function parseChallenge(challenge:String):Object
        {
            var pattern:RegExp = /(?:\s*,)*\s*(\w+)=("([^\\"]+|\\.)*"|[^,]+)\s*(?:,\s*)*/g; //"
            var result:Object = pattern.exec(challenge);
            var obj:Object = {};
            while (result != null) {
                var key:String = result[1];
                // FIXME: realm and auth-param may be multiple?
                obj[key] = filterValue(result[2]);
                result = pattern.exec(challenge);
            }
            return obj;
        }

        public function filterValue(v:String):String
        {
            var result:String;
            var matched:Array = v.match(/^"(.*)"$/);
            if (matched != null) {
                return matched[1].replace(/\\(.)/, "$1");
            } else {
                return v;
            }
        }

    }
}

