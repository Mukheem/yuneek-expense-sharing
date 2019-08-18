pragma solidity ^0.5.9;
import "./Squads.sol";
import "./Users.sol";

contract ShareExpense is Squads,Users{
    function shareExpenditure(
       string memory _spentBy,
       string memory _shareAmongMembersOf,
       uint _amountToBeShared,
       string memory units
    ) public{
       squadMemberInfo[] memory squadMembers = getSquadMembers(_shareAmongMembersOf);
        uint _totalMembers = squadMembers.length;
        uint _sharePerHead = _amountToBeShared/_totalMembers;
    }
}