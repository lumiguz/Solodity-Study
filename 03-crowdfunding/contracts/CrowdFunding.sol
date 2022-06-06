// SPDX-License-Identifier: GLP-3.0
pragma solidity >=0.4.22 <0.9.0;

contract crowdFunding{
    /*string public id;
    string public name;
    string public description;
    address payable public author;
    address private owner;
    uint public state;
    uint public funds;
    uint public fundraisingGoal;*/

    enum State{Opened, Closed}

    struct Project{
        string id;
        string name;
        string description;
        address payable author;
        State state;
        uint funds;
        uint fundraisingGoal;
    }

    Project public project;

    event projectFounded(
        string projectid,
        uint value
    );
    event stateProject(
        string id,
        State state
    );

    constructor(
        string memory _id,
        string memory _name,
        string memory _description,
        uint _fundraisingGoal
    ){
        project = Project(
        _id,
        _name,
        _description,
        payable(msg.sender),
        State.Opened,
        0,
        _fundraisingGoal
        );
    }
    modifier onlyAuthor(){
        require(
            project.author == msg.sender,
            "Only owner can modify the variables"
        );
        _;
    }
    modifier notAuthor(){
        require(
            project.author != msg.sender,
            "You can't fund the project yourselft"
        );
        _;
    }
    
    function fundProject() public payable notAuthor{
        require(project.state != State.Closed, "The project is closed can not recive funds");
        require(msg.value > 0, "Fund value must be greater than 0");
        project.author.transfer(msg.value);
        project.funds += msg.value;
        emit projectFounded(project.id, msg.value);
    }
    function changeProjectSatate(State newState) public onlyAuthor{
        require(project.state != newState, "New state must be different");
        project.state = newState;
        emit stateProject(project.id, newState);
    }
}
