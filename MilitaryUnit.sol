pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "GameObj.sol";
import "BaseStationInterface.sol";
import "MilitaryUnitInterface.sol";

contract MilitaryUnit is GameObj, MilitaryUnitInterface {
   
    address public addressBaseStation;
    uint internal attackPower;

    constructor(BaseStationInterface addrBaseStation) public { 
        tvm.accept();

        addressBaseStation = addrBaseStation;
 
        addrBaseStation.addMilitaryUnit();        
    }

    function takeAttack(uint attackingPower, address addrBaseStation) virtual external override {
        tvm.accept();

        if(addrBaseStation != addressBaseStation) {
            uint protectPower = getPowerOfProtection();

            pointsOfLive += protectPower;

            if (pointsOfLive <= attackingPower) {
                destructionOfObject(msg.sender);
            } else {
                pointsOfLive -= attackingPower;    
            } 
        } 
    }

    function attack(GameObjectInterface attackedObject) public {
        tvm.accept();

        uint powerOfAttack = getPowerOfAttack();
        attackedObject.takeAttack(powerOfAttack, addressBaseStation);
    } 

    function getPowerOfAttack() public returns(uint) {
        tvm.accept();
        return attackPower;
    } 

    function destructionOfObject(address killer) virtual internal override {
        tvm.accept();

        BaseStationInterface(addressBaseStation).deleteMilitaryUnit();

        killer.transfer(0, true, 160);
    } 

    function deathByBaseStation(address killer) external override {
        tvm.accept();

        if (addressBaseStation == msg.sender) {
            killer.transfer(0, true, 160);    
        }
    } 
}