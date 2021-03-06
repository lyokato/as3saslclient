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

    import com.hurlant.crypto.Crypto;
    import com.hurlant.crypto.hash.HMAC;
    import com.hurlant.util.Hex;

    import org.coderepos.sasl.SASLConfig;

    public class CRAM_MD5 implements ISASLMechanism
    {
        private var _config:SASLConfig;

        public function CRAM_MD5(config:SASLConfig)
        {
            _config = config;
        }

        public function get name():String
        {
            return "CRAM-MD5";
        }

        public function start():String
        {
            return "";
        }

        public function step(challenge:String):String
        {
            var username:String = (_config.username != null)
                ? _config.username : "";
            var password:String = (_config.password != null)
                ? _config.password : "";

            var hmac:HMAC = Crypto.getHMAC("md5");
            var encoded:String = Hex.fromArray(hmac.compute(
                stringToBytes(password), stringToBytes(challenge)));
            return username + " " + encoded;
        }

        private function stringToBytes(s:String):ByteArray
        {
            var b:ByteArray = new ByteArray();
            b.writeUTFBytes(s);
            b.position = 0;
            return b;
        }
    }
}

