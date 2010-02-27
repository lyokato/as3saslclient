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
    import org.coderepos.sasl.mechanisms.ISASLMechanism;

    public class SASLMechanismFactory
    {
        protected var _mechanisms:Object;

        public function SASLMechanismFactory()
        {
            _mechanisms = {};
        }

        public function supportMechanism(mech:ISASLMechanism):void
        {
            _mechanisms[mech.name] = mech;
        }

        public function getMechanism(mechName:String):ISASLMechanism
        {
            return (mechName in _mechanisms)
                ? _mechanisms[mechName] : null;
        }

    }
}

