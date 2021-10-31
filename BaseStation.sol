pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "GameObj.sol";
import "BaseStationInterface.sol";
import "MilitaryUnitInterface.sol";

contract BaseStation is GameObj, BaseStationInterface {

    address[] private relatedMilitaryUnits;

    function addMilitaryUnit() external override{
        tvm.accept();

        address addrUnit = msg.sender;

        relatedMilitaryUnits.push(msg.sender);
    } 

    function deleteMilitaryUnit() external override {
        tvm.accept();

        address addrUnit = msg.sender;

        if (relatedMilitaryUnits.length > 0) {
        
            bool addrUnitFound = false;   

            for (uint8 i = 0; i < relatedMilitaryUnits.length; i++) {

                if(!addrUnitFound && relatedMilitaryUnits[i] == addrUnit) {
                    addrUnitFound = true;
                }

                if(addrUnitFound) {
                    relatedMilitaryUnits[i] = relatedMilitaryUnits[i + 1];
                }
            }

            if(addrUnitFound){
                relatedMilitaryUnits.pop();
            }           
        }
    } 

    function takeAttack(uint attackingPower, address addrBaseStation) virtual external override {
        tvm.accept();

        bool isRelatedUnit  = false;

        if (relatedMilitaryUnits.length > 0) {

            for (uint8 i = 0; i < relatedMilitaryUnits.length; i++) {

                if(msg.sender == relatedMilitaryUnits[i]) {
                    isRelatedUnit = true;
                    break;
                }
            }
        }

        if(!isRelatedUnit) {
            uint protectPower = getPowerOfProtection();

            pointsOfLive += protectPower;

            if (pointsOfLive <= attackingPower) {
                destructionOfObject(msg.sender);
            } else {
                pointsOfLive -= attackingPower;    
            } 
        } 
    }

    function destructionOfObject(address killer) virtual internal override {
        tvm.accept();

        destructionRelatedMilitaryUnits(killer);

        killer.transfer(0, true, 160);
    } 

    function destructionRelatedMilitaryUnits(address killer) private {
        
        if (relatedMilitaryUnits.length > 0) {
        
            for (uint8 i = 0; i < relatedMilitaryUnits.length; i++) {
                MilitaryUnitInterface(relatedMilitaryUnits[i]).deathByBaseStation(killer);   
            }    
        }  
    }
}