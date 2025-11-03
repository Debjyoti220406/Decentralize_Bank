// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SmartBank {
    // Mapping to store each user's balance
    mapping(address => uint256) public balances;

    // Event logs (for on-chain history)
    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Deposit Ether into the bank
    function deposit() public payable {
        require(msg.value > 0, "Must send some ether");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw Ether from the bank
    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit Withdraw(msg.sender, _amount);
    }

    // View contract balance (total Ether stored)
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
