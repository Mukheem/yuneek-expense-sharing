pragma solidity ^0.5.9;
pragma experimental ABIEncoderV2;
import "./Users.sol";

contract Squads is Users{

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
     //Using an Instance of Users contract to get the userName
    Users user = Users(0xe3632B9aB0571d2601e804DfDDc65EB51AB19310);

    //Mapping to fetch SquadDetails when SquadName is provided
    mapping(string => squadInfo) public squadDetails;
    
    //Mapping to figure out in how many squads one address is part of.
    mapping(address => string[]) private addressToSquadNames;

    //Function to create a Squad/Group and name that group
    function createSquad(string memory _squadName)  public ifSquadnameAvailable(_squadName){
        squadDetails[_squadName].squadName = _squadName;
        squadDetails[_squadName].createdBy = msg.sender;
        addMember(msg.sender,_squadName);
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
    modifier isSquadMemeberAddressExists(address  _squadMemberAddress,string memory _squadName){
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
    function addMember(address _memberAddress,string memory _squadName) public
    isSquadMemeberAddressExists( _memberAddress,_squadName){
       
        string memory  _memberName = user.getUserNameFromAddress(_memberAddress);
        squadMemberInfo memory squadMember;
        squadMember.memberName = _memberName;
        squadMember.memberAddress = _memberAddress;
        squadMember.addedBy = msg.sender;
        addressToSquadNames[_memberAddress].push(_squadName);
        squadDetails[_squadName].squadMembers.push(squadMember);
        emit AddedSquadMember(squadMember);
    }
    
    function getSquadMembers(string memory _squadname) public view returns(squadMemberInfo[] memory squadMembers){
        return squadDetails[_squadname].squadMembers;
    }

    function getSquadNamesOfAnAddress(address _address) public view returns(string[] memory _squadNames){
        return addressToSquadNames[_address];
    }
    function shareExpenditure(
       string memory _spentBy,
       string memory _shareAmongMembersOf,
       uint _amountToBeShared,
       bytes32  units
    ) public{
       squadMemberInfo[] memory squadMembers = getSquadMembers(_shareAmongMembersOf);
       
        uint _totalMembers = squadMembers.length;
       // squadMemberInfo[] memory squadMembers =  squadDetails[_shareAmongMembersOf].squadMembers;
        uint _sharePerHead = _amountToBeShared/_totalMembers;
        address _spentByAddress = user.getAddressFromuserName(stringToBytes32(_spentBy));
        for(uint i = 0; i < _totalMembers; i++){
            userOwes memory debts;
            debts.lenderAddress = _spentByAddress;
            debts.lenderName = _spentBy;
            debts.amountToPay = _sharePerHead;
            debts.units = units;
            debts.isActive = true;
            if(squadMembers[i].memberAddress != _spentByAddress){
                userDetails[stringToBytes32(squadMembers[i].memberName)].debts.push(debts);
                userLoans memory loans;
                loans.borrowerAddress = squadDetails[_shareAmongMembersOf].squadMembers[i].memberAddress;
                loans.borrowerName = squadDetails[_shareAmongMembersOf].squadMembers[i].memberName;
                loans.amountToGetback = _sharePerHead;
                loans.units = units;
                loans.isActive = true;
                userDetails[stringToBytes32(_spentBy)].loans.push(loans);
            }
        }
    }
}