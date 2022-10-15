# Push Yourself

### A genuine dApp that gives tokens if you finish your tasks on your to-do list. Designed to work with front-end.
-----------------------------------------
A struct, **TodoList** has 4 traits:
- String: The name of the task
- Boolean: A completion phase of the task
- Address: Address of the creator
- Uint: The amount the creator will get when he/she finishes the task

Boolean "completed" is set false by default.

**Listsindexed is a mapping** of TodoList with uint to differentiate the days (or specific timelines). Thus, users can change the timeline to the next day. Once the user changes the day, it cannot be reversed. 

>Don't delay today's work to tomorrow


**A modifier, ShouldBeOwner**, takes a parameter and ensures that the message's sender is the same as the creator.

### Functions
 ---------------------------------------------
![image](https://user-images.githubusercontent.com/76889160/194780866-10781739-bbe8-49f9-9763-1e09d6636c88.png)

The contract has 5 functions:

1- ***Create:*** That function takes the necessary parameters, and pushes them into the struct. If you give the right data type, it will add a task to the list. The amount that the user will receive after finishing a task is determined by him/herself.

2- ***Another Day:*** That function changes the day (or whatever you want to take as time reference like hour, week or so)

3- ***Get Info:*** A tasklist string will store the data on the memory with a predetermined array length to increase gas efficiency. It takes the parameter day and returns the tasks of that day.

4- ***Toggle And Get Token:*** There is a modifier "ShouldBeOwner" to make sure that users' to-do lists and contracts' tokens are safe. A require statement prevents the exploits from claiming already finished tasks' tokens.

5- ***All Completed:*** The uint total is to hold values of completed tasks. It will behave as a score. Let's say we have 4 tasks and we completed 3 of them. The total variable will be 75 since we are dividing 100 by 4, then adding 25 three times. If the value of the total is not 100, the transaction of bonus tokens will revert.

**Note:** IERC20.sol is also a customized contract which you can arrange everything from *customization* function.

-----------------------------

Built with :heartpulse: by [Me](https://medium.com/@kyatzu)
