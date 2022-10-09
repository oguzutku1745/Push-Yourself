// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";


contract Pushyourself {

    // A dApp which gives tokens if you finish specific tasks on your todo list 

    event addTodo(address, string, uint);
    event newDay(uint);
    event doneAndGotToken(string, address, uint);
    event endOfTheDay(address, uint);

    struct TodoList {
        string task;
        bool completed;
        address creator;
        uint amount;
    }

    IERC20 public immutable token;
    uint public day = 0;
    mapping(uint => TodoList[]) public Listsindexed;


    constructor (address _token) {
        token = IERC20(_token);
    }

    modifier ShouldBeOwner (uint index) {
        TodoList memory todo = Listsindexed[day][index];
        require(todo.creator == msg.sender , "You are not the creator");
        _;
    }

    function create(string calldata _task, uint _amount) external {
        Listsindexed[day].push(TodoList({
            task: _task,
            completed: false,
            creator: msg.sender, 
            amount: _amount
        }));
        emit addTodo(msg.sender, _task, _amount);
    }

    function anotherDay() external {
        day += 1;
        emit newDay(day);
    }

    function getInfo(uint _day) external view returns(string[] memory){
        string[] memory tasklist = new string[](Listsindexed[_day].length); // Set a limit to array and increase gas efficiency with holding it inside function
        for(uint256 i=0; i < Listsindexed[_day].length; i++){
        tasklist[i] = (Listsindexed[_day][i].task);
        }
        return tasklist;
    }



    function toggleAndGetToken (uint index) external payable ShouldBeOwner(index){
        TodoList storage todo = Listsindexed[day][index];    
        require(todo.completed == false, "You already achieved this task");
        todo.completed = true;
        token.transfer(msg.sender, todo.amount);
        emit doneAndGotToken(todo.task, msg.sender, todo.amount);
    } 


    // Give 100 bonus tokens if all the tasks of the day completed.
    function AllCompleted () external payable  {
        uint total = 0;
        for(uint256 i=0; i < Listsindexed[day].length; i++){
        if(Listsindexed[day][i].completed == true){
        total += 100/Listsindexed[day].length;
        }}
        require(total == 100, "You didn't complete all the tasks");
        token.transfer(msg.sender,100);
        emit endOfTheDay(msg.sender, msg.value);
    }
    
}
