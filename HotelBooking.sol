pragma solidity >= 0.4.16 <0.9.0;

contract hotelBooking {

    enum Status {occupied, vacant}
    Status currentStatus;
    address payable public owner;

    event Occupy(address _occupant, uint _value);
    
    constructor () public payable {
        currentStatus = Status.vacant;
        owner = payable(msg.sender);
    }


    modifier checkStatus {
        require(currentStatus == Status.vacant, "currently occupied!");
        _; // end of modifier
    }

    modifier checkValue(uint _amount) {
        require(msg.value>= _amount,"not enough ether");
        _;
    }

    function booking() public payable checkStatus checkValue(2 ether) {


        //it will check the condition if it is true then it continues to execute code further otherwise it will pause here and displys the text

        currentStatus = Status.occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender,msg.value);

    }
}