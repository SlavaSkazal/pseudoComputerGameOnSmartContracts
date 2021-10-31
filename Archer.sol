pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "MilitaryUnit.sol";

contract Archer is MilitaryUnit {

    constructor(BaseStationInterface addrBaseStation) MilitaryUnit(addrBaseStation) public {  
        attackPower = 4;
        pointsOfLive = 8; 
        protectionPower = 2;   
    }
}