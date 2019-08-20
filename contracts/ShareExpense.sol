pragma solidity ^0.5.9;
import "./Squads.sol";
import "./Users.sol";

contract ShareExpense is Squads,Users{
    function shareExpenditure(
       string memory _spentBy,
       string memory _shareAmongMembersOf,
       uint _amountToBeShared,
       bytes32  units
    ) public{
       squadMemberInfo[] memory squadMembers = getSquadMembers(_shareAmongMembersOf);
        uint _totalMembers = squadMembers.length;
        uint _sharePerHead = _amountToBeShared/_totalMembers;
        address _spentByAddress = getAddressFromuserName(stringToBytes32(_spentBy));
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
                loans.borrowerAddress = squadMembers[i].memberAddress;
                loans.borrowerName = squadMembers[i].memberName;
                loans.amountToGetback = _sharePerHead;
                loans.units = units;
                loans.isActive = true;
                userDetails[stringToBytes32(_spentBy)].loans.push(loans);
            }
        }
    }
}