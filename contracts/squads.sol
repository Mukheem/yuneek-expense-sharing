pragma solidity ^0.5.9;

contract Squads{

    struct squadInfo{
        string squadName;
        address[] squadMembers;
    }
    squadInfo SI;

    //Mapping to fetch SquadDetails when SquadName is provded
    mapping(string => squadInfo) internal _squadDetails;

    //Mapping to track SquadName
    mapping(string => bool) internal _squadNameExistence;
    
    //Function to create a Squad/Group and name that group
    function createSquad(address _addressesToBeGrouped,string memory _squadName) public returns(string memory isCreated){
        SI.squadName = _squadName;
        SI.squadMembers.push(_addressesToBeGrouped);
        _squadNameExistence[_squadName] = true;
        return SI.squadName;
    }

    //Function to check if SquadName is already in use
    function squadNameExists(string memory _squadName) public view returns(bool isExists){
       
        return(true);
    }

}