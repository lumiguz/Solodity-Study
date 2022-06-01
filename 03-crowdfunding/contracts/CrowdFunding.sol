// SPDX-License-Identifier: GLP-3.0
pragma solidity >=0.4.22 <0.9.0;

contract crowdFunding{
    string public id;
    string public name;
    string public description;
    address payable public author;
    address private owner;
    string public state = 'Opened';
    bool fundable;
    uint public funds;
    uint public fundraisingGoal;

    constructor(string memory _id, string memory _name, string memory _description, uint _fundraisingGoal){
        id = _id;
        name = _name;
        description = _description;
        fundraisingGoal = _fundraisingGoal;
        author = payable(msg.sender);
        
    }
    modifier onlyAuthor(){
        require(
            author == msg.sender,
            "Only owner can modify the variables"
        );
        _;
    }
    modifier notAuthor(){
        require(
            author != msg.sender,
            "You can't found the project yourselft"
        );
        _;
    }
    event projectFounded(
        string projectid,
        uint value
    );
    event stateProject(
        string state
    );
    function fundProject() public payable notAuthor{
        author.transfer(msg.value);
        funds += msg.value;
        emit projectFounded(id, msg.value);
    }
    function changeProjectSatate(string calldata newSatate) public onlyAuthor{
        state = newSatate;
        emit stateProject(state);
    }
}