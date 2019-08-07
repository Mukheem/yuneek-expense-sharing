pragma solidity ^0.5.9;

contract Squads{

    struct squadMemberInfo{
        string memberName;
        address memberAddress;
        //string _squadName;
    }
    struct squadInfo{
        string squadName;
        //address[] squadMembers;
        squadMemberInfo[] squadMembers;
    }
    squadInfo[] public SI;
    //squadMemberInfo[] public SMI;
    

    //Mapping to fetch SquadDetails when SquadName is provded
    mapping(string => squadInfo) internal _squadDetails;

    //Mapping to track SquadName
    mapping(string => bool) public _squadNameExistence;
    
    //Function to create a Squad/Group and name that group
    function createSquad(string memory _squadName)  public ifSquadnameAvailable(_squadName) returns(string memory isCreated){
        _squadNameExistence[_squadName] = true;
       /* SI.squadName = _squadName;
        SI.squadMembers.push(_addressesToBeGrouped);
        _squadNameExistence[_squadName] = true;*/
        return _squadName;
    }
    modifier ifSquadnameAvailable(string memory _squadName){
        require(
            _squadNameExistence[_squadName] != true,"Oops..!!! Squad name already taken..."
        );
        _;
    }
    //Function to add Members to an existing Squad
    function addMember(address _memberAddress, string memory _memberName) public pure returns(uint8 isAdded){
        squadMemberInfo[] memory squadMember = new squadMemberInfo[](1);
        squadMemberInfo memory squadMemb = squadMemberInfo(_memberName,_memberAddress);
        squadMember[0] = squadMemb;
        //squadInfo memory squadInformation = squadInfo(_squadName,SMI);
        //SI.push(squadInformation);
        return 1;
    }

    //Function to check if SquadName is already in use
    /*function squadNameExists(string memory _squadName) public view returns(bool isExists){
       
        return(true);
    }*/

}