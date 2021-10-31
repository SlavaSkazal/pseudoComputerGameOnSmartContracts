pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

interface GameObjectInterface {  
    function takeAttack(uint attackPower, address addrBaseStation) external;
}