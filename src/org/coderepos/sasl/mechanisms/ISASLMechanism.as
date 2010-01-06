package org.coderepos.sasl.mechanisms
{
    public interface ISASLMechanism
    {
        function get name():String;
        function start():String;
        function step(challenge:String):String;
    }
}

