pragma solidity ^0.5.9;
pragma experimental ABIEncoderV2;

contract Users{

    struct userOwes{
        address lenderAddress;
        string lenderName;
        string lenderFullName;
        bool isActive;
        uint amountToPay;
        bytes32 units;
    }
    struct userLoans{
        address borrowerAddress;
        string borrowerName;
        string borrowerFullName;
        bool isActive;
        uint amountToGetback;
        bytes32 units;
    }
    struct userInfo{
        bytes32 userName;
        bytes32 userPassword;
        bool isUsed;
        address userAddress;
        string userFirstname;
        string userLastName;
        string userFullName;
        string userEmailId;
        string userContactNumber;
        userOwes[] debts;
        userLoans[] loans;
    }
    //Mapping to fetch userDetails basis on UserName
    mapping(bytes32 => userInfo) public userDetails;

    //Mapping to userName and Address. - To be used when adding a member to a Squad
    mapping(address => bytes32) private userAddressToUsername;

    //Modifier to check if UserName is already in use
    modifier isUsernameAvailable(bytes32 _userName){
        require(
            userDetails[_userName].isUsed != true,
            "Oops..!!! User name is already in use..."
        );
        _;
    }

    //Function to Register a user
    function registeruser(
        bytes32 _username,
        bytes32 _password,
        address _address,
        string memory _firstName,
        string memory _lastName,
        string memory _fullname,
        string memory _mailid,
        string memory _contactNumber
        ) public isUsernameAvailable(_username) returns(bool isUserCreated)
        {
        userDetails[_username].userName = _username;
        userDetails[_username].userPassword = _password;
        userDetails[_username].userAddress = _address;
        userDetails[_username].userFirstname = _firstName;
        userDetails[_username].userLastName = _lastName;
        userDetails[_username].userFullName = _fullname;
        userDetails[_username].userEmailId = _mailid;
        userDetails[_username].userContactNumber = _contactNumber;
        userDetails[_username].isUsed = true;
        userAddressToUsername[_address] = _username;
        return userDetails[_username].isUsed;
    }

    //Function to return username of an Address.
    function getUserNameFromAddress(address _address) public view returns(string memory _userName){
      return bytes32ToString(userAddressToUsername[_address]);
    }

    function getAddressFromuserName(bytes32 _userName) public view returns(address _address){
        return userDetails[_userName].userAddress;
    }

    //Function to Convert Bytes32 to String
    function bytes32ToString(bytes32 _bytes32) public pure returns (string memory convertedString){
        bytes memory bytesArray = new bytes(32);
        for (uint256 i; i < 32; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }

    //Function to convert String to Bytes32
    function stringToBytes32(string memory source) public pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly {
            result := mload(add(source, 32))
        }
}
  function returnDebts(string memory _name) public view returns(userOwes[] memory _allDebts){
        return userDetails[stringToBytes32(_name)].debts;
    }
    function returnAdjustments(string memory _name) public view returns(userLoans[] memory _allLoans){
        return userDetails[stringToBytes32(_name)].loans;
    }
    
}