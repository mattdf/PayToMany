pragma solidity ^0.4.0;

contract PayMany {

	event PaymentSuccess(
		address payee,
		uint value
	);

	event PaymentFailure(
		address payee,
		uint value
	);

	function PayXToList(address[] list, uint value) public payable {

		uint returnfunds = msg.value;
		uint sentfunds = 0;

		// do some overflow checks and bounds checks
		if ((value * list.length) > msg.value || value < (value * list.length) || value > msg.value)
			throw;

		for (uint i = 0; i < list.length; i++){
			if (!list[i].send(value)){
				returnfunds -= value;
				PaymentFailure(list[i], value);
			}
			else {
				sentfunds += value;
				PaymentSuccess(list[i], value);
			}
		}


		if ((returnfunds + sentfunds != msg.value) || !msg.sender.send(returnfunds)){
			throw;
		}


	}

	function PayValsToList(address[] list, uint[] values) public payable {

		uint sum = 0;
		uint i;

		uint returnfunds = msg.value;
		uint sentfunds = 0;


		for (i = 0; i < list.length; i++){
			if (!list[i].send(values[i])){
				returnfunds -= values[i];
				PaymentFailure(list[i], values[i]);
			}
			else {
				sentfunds += values[i];
				PaymentSuccess(list[i], values[i]);
			}
		}

		if ((returnfunds + sentfunds != msg.value) || !msg.sender.send(returnfunds)){
			throw;
		}

	}


}
