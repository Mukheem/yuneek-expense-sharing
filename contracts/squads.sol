pragma solidity ^0.5.9;
pragma experimental ABIEncoderV2;

contract Squads{

    struct squadMemberInfo{
        string memberName;
        address memberAddress;
        address addedBy;
    }
    struct squadInfo{
        bool isTaken;
        string squadName;
        address createdBy;
        squadMemberInfo[] squadMembers;
    }
    
    event AddedSquadMember(squadMemberInfo who);
    event SquadCreatedBy(address creator,string SquadName);

    //Mapping to fetch SquadDetails when SquadName is provded
    mapping(string => squadInfo) public squadDetails;
    
    //Function to create a Squad/Group and name that group
    function createSquad(string memory _squadName,string memory _memberName)  public ifSquadnameAvailable(_squadName){
        squadDetails[_squadName].squadName = _squadName;
        squadDetails[_squadName].createdBy = msg.sender;
        addMember(msg.sender,_memberName,_squadName);
        squadDetails[_squadName].isTaken = true;
        emit SquadCreatedBy(squadDetails[_squadName].createdBy,squadDetails[_squadName].squadName);
    }
    //Modifier to check if SquadName is already in use
    modifier ifSquadnameAvailable(string memory _squadName){
        require(
            squadDetails[_squadName].isTaken != true,"Oops..!!! Squad name already taken..."
        );
        _;
    }

    //Modifier to check if SquadMember(Address) already exists in the squad [Modifier Excluded]
    modifier isSquadMemeberAddressExists(address  _squadMemberAddress,string memory _memberName,string memory _squadName){
        if(squadDetails[_squadName].isTaken == true){
            squadMemberInfo[] memory squadMembers = squadDetails[_squadName].squadMembers;
            for (uint i = 0; i < squadMembers.length; i++){
              require(squadMembers[i].memberAddress != _squadMemberAddress,"Address already exists in the Squad...!!!");
              //require(keccak256(abi.encodePacked((squadMembers[i].memberName))) != keccak256(abi.encodePacked((_memberName))),
              //"Member Name already exists in the Squad...!!!");
            }
        }
        _;
    }
    //Function to add Members to an existing Squad
    function addMember(address _memberAddress, string memory _memberName,string memory _squadName) public
    isSquadMemeberAddressExists( _memberAddress,_memberName,_squadName){
        squadMemberInfo memory squadMember;
        squadMember.memberName = _memberName;
        squadMember.memberAddress = _memberAddress;
        squadMember.addedBy = msg.sender;
        squadDetails[_squadName].squadMembers.push(squadMember);
        emit AddedSquadMember(squadMember);
    }
    
    function getSquadMembers(string memory _squadname) public view returns(squadMemberInfo[] memory squadMembers){
        return squadDetails[_squadname].squadMembers;
    }
}