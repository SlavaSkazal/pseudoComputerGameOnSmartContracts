pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "GameObjectInterface.sol";

contract GameObj is GameObjectInterface {

    uint internal pointsOfLive = 10;
    uint internal protectionPower = 3;

    function getPowerOfProtection() virtual public returns(uint) {
        tvm.accept();
        return protectionPower;
    } 
   
    function takeAttack(uint attackingPower, address addrBaseStation) virtual external override {
        tvm.accept();

        uint protectPower = getPowerOfProtection();

        pointsOfLive += protectPower;

        if (pointsOfLive <= attackingPower) {
            destructionOfObject(msg.sender);
        } else {
            pointsOfLive -= attackingPower;    
        }  
    }

    function destructionOfObject(address killer) virtual internal {
        tvm.accept();
        killer.transfer(0, true, 160);
    } 
}