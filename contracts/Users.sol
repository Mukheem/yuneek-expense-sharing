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
        return userDetails[_username].isUsed;
    }
}