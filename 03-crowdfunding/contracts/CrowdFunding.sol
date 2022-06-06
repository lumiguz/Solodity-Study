// SPDX-License-Identifier: GLP-3.0
pragma solidity >=0.4.22 <0.9.0;

contract crowdFunding{
    string public id;
    string public name;
    string public description;
    address payable public author;
    address private owner;
    uint public state;
    uint public funds;
    uint public fundraisingGoal;

    event projectFounded(
        string projectid,
        uint value
    );
    event stateProject(
        string id,
        uint state
    );

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
            "You can't fund the project yourselft"
        );
        _;
    }
    
    function fundProject() public payable notAuthor{
        require(state != 1, "The project is closed can not recive funds");
        require(msg.value > 0, "Fund value must be greater than 0");
        author.transfer(msg.value);
        funds += msg.value;
        emit projectFounded(id, msg.value);
    }
    function changeProjectSatate(uint newState) public onlyAuthor{
        require(state != newState, "New state must be different");
        state = newState;
        emit stateProject(id, newState);
    }
}
