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

