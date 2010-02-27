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
    import org.coderepos.sasl.SASLConfig;

    public class LOGIN implements ISASLMechanism
    {
        private var _config:SASLConfig;

        public function LOGIN(config:SASLConfig)
        {
            _config = config;
        }

        public function get name():String
        {
            return "LOGIN";
        }

        public function start():String
        {
            return "";
        }

        public function step(challenge:String):String
        {
            var res:String = "";
            if (challenge.match(/password/i) != null)
                res = _config.password;
            else if (challenge.match(/username/i) != null)
                res = _config.username;
            return res;
        }
    }
}

