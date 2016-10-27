//
//  BankAccountTests.swift
//  BankAccountTests
//
//  Created by André Henrique da Silva on 10/19/15.
//  Copyright © 2015 André Henrique da Silva. All rights reserved.
//

import XCTest

@testable import BankAccount

class BankAccountTests: XCTestCase {
    
    var account: Account!
    
    override func setUp() {
        super.setUp()
        
        self.account = Account()
        
    }
    
    override func tearDown() {
        
        self.account.close()
        
        super.tearDown()
    }
    
    // MARK: test initializers
    
    func testInitNumberOfTransactionsNoInitialBalance() {
        
        XCTAssert(account.statement().count == 2, "When starting an account with no initial money, number of transactions should be two.")
    }
    
    func testInitNumberOfTransactionsWhenInitialBalance() {
        
        if self.account != nil {
            self.account.close()
        }
        
        self.account = Account(balance: 200.0)
        
        XCTAssert(self.account.statement().count == 3, "When starting an account with initial money, number of transactions should be three.")
    }

    // MARK: test deposits
    
    func testDepositAndBalance() {
        
        account.deposit(100.0)
        
        XCTAssertEqual(account.available(), 100.0 + account.limitForAccount() - Constants.MonthlyChargeValue, "Balance should be limit + 100.0 - charge monthly.")
        
    }

    func testDepositTransactions() {
        
        account.deposit(100.0)
        
        XCTAssertEqual(account.statement().count, 3, "Number of transactions should be three.")
    }
    
    func testTotalDeposits(){
        
        account.deposit(100.0)
        account.deposit(100.0)
        account.deposit(100.0)
        account.deposit(100.0)
        
        XCTAssertEqual(account.statement().count, 7, "Number of transactions should be seven.")
    }
    
    // MARK: test withdraws
    
    func testWithDrawAndBalance() {
        
        _ = account.withdraw(500.0)
        
        XCTAssertEqual(account.available(), account.limitForAccount() - Constants.MonthlyChargeValue - 500.0, "Balance should be limit + 100.0 - charge monthly.")
        
    }
    
    func testWithDrawTransactions() {

        _ = account.withdraw(500.0)
        
        XCTAssertEqual(account.statement().count, 3, "Number of transactions should be three.")
    }
    
    func testTotalWithdraws(){
        
        _ = account.withdraw(100.0)
        _ = account.withdraw(100.0)
        _ = account.withdraw(100.0)
        _ = account.withdraw(100.0)
        
        XCTAssertEqual(account.statement().count, 7, "Number of transactions should be seven.")
    }
    
    func testWithdrawWithHugeAmount(){
        
        XCTAssertFalse(account.withdraw(100000.0), "Withdraw shoulb be false / denied.")
        
    }
    
    func testWithdrawWhenNoMoneyAvailable() {
        _ = account.withdraw(995.0)
        
        XCTAssertFalse(account.withdraw(1.0), "Withdraw should be false / denied.")
    }
    
    
    // MARK: test loan
    
    func testSimpleLoan(){
        
        XCTAssertTrue(account.loan(300), "Loan should occur normally.")
        
    }
    
    func testHugeValue(){
        XCTAssertFalse(account.loan(1000.0), "Should deny load.")
    }
    
    func testValueChargedForLoan(){
        _ = account.loan(300.0)
        
        let value = account.available()
        
        XCTAssert(value == (Constants.LimitValue - Constants.MonthlyChargeValue + 300.0 - (300.0 * Constants.ChargePerLoanPercentage)), "Value charged should be 300.0 x 0.06.")
        
    }
    
    // MARK: test total statement prints
    
    func testTotalPrints(){
        account.printStatement()
        account.printStatement()
        account.printStatement()
        account.printStatement()
        
        XCTAssertEqual(account.statement().count, 3, "Number of transactions should be three.")
    }

}
