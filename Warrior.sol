pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "MilitaryUnit.sol";

contract Warrior is MilitaryUnit {

    constructor(BaseStationInterface addrBaseStation) MilitaryUnit(addrBaseStation) public {  
        attackPower = 5;
        pointsOfLive = 7; 
        protectionPower = 2;      
    }
}