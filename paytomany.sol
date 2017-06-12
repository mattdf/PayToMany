pragma solidity ^1.0.0;

contract PayMany {


	function PayXToList(address[] list, uint value) public payable {

		// if the value to send out is not exactly the amount of eth sent to the
		// contract we know that somewhere in the loop the contract will fail
		// do some overflow checks as well
		if ((value * list.length) != msg.value || value < (value * list.length) || value > msg.value)
			throw;

		for (int i = 0; i < list.length, i++){
			if (!list[i].send(value))
				throw;
		}


	}

	function PayValsToList(address[] list, uint[] values) public payable {

		uint sum = 0;

		// if there's not one value specified per address throw
		if (list.length != values.length)
			throw;

		for (int i = 0; i < values.length; i++){
			sum += value[i];
			// make sure we only try to send what we have, and some overflow checks
			if (sum > msg.value || sum < value[i])
				throw;
		}

		// if at the end of the tally the sum doesn't equal the msg.value, throw,
		// else ETH will be stuck or likely the list was constructed wrong
		if (sum != msg.value)
			throw;

		for (int i = 0; i < list.length, i++){
			if (!list[i].send(value[i]))
				throw;
		}

	}


}
