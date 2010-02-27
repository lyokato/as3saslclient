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

package org.coderepos.sasl
{
    import org.coderepos.sasl.mechanisms.PLAIN;
    import org.coderepos.sasl.mechanisms.LOGIN;
    import org.coderepos.sasl.mechanisms.ANONYMOUS;
    import org.coderepos.sasl.mechanisms.EXTERNAL;
    import org.coderepos.sasl.mechanisms.CRAM_MD5;
    //import org.coderepos.sasl.mechanisms.DIGEST_MD5;
    //import org.coderepos.sasl.mechanisms.GSSAPI;

    public class SASLMechanismDefaultFactory extends SASLMechanismFactory
    {
        private var _config:SASLConfig;

        public function SASLMechanismDefaultFactory(authcid:String, 
            password:String="", authzid:String="")
        {
            var config:SASLConfig = new SASLConfig(authcid, password, authzid);
            supportMechanism(new PLAIN(config));
            supportMechanism(new LOGIN(config));
            supportMechanism(new ANONYMOUS(config));
            supportMechanism(new EXTERNAL(config));
            supportMechanism(new CRAM_MD5(config));
            //supportMechanism(new DIGEST_MD5());
            //supportMechanism(new EXTERNAL());
        }
    }
}
