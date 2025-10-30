create database financial;
use financial;

show tables;
desc financial_loan;
select*from financial_loan;

alter table financial_loan change ï»¿id id int;

-- total loan application
select count(id) as `total loan application` from financial_loan;

-- total funded amount
select format(sum(loan_amount),0) as `total funded amount` from financial_loan;

-- total received amount
select format(sum(total_payment),0) as `total received amount` from financial_loan;

-- average interest rate
select concat(round(avg(int_rate)*100,2), '%') as `average interest rate` from financial_loan;

-- average debt to income
select concat(round(avg(dti)*100,2),'%') as `average debt to income` from financial_loan;

-- average installment
select round(avg(installment),2) as `average installment` from financial_loan;

-- loan status (good loan & bad loan)

-- good loan
select concat(round(count(case when loan_status='Fully Paid' or loan_status='Current' then id end)*100/count(id),2),'%') as `good loan (%)` from financial_loan;
select count(case when loan_status='fully paid' or loan_status='current' then id end) as `total loan application (good loan)` from financial_loan;
select format(sum(loan_amount),0) as `total funded amount (good loan)` from financial_loan where loan_status in ('fully paid','current');
select format(sum(case when loan_status='fully paid' or loan_status='current' then total_payment end),0) as `total received amount (good loan)` from financial_loan;

-- bad loan
select concat(round(count(case when loan_status='charged off' then id end)*100/count(id),2),'%') as `bad loan (%)` from financial_loan;
select count(case when loan_status='charged off' then id end) as `total loan application (bad loan)` from financial_loan;
select format(sum(loan_amount),0) as `total funded amount (bad loan)` from financial_loan where loan_status='charged off';
select format(sum(case when loan_status='charged off' then total_payment end),0) as `total received amount (bad loan)` from financial_loan;

select case when loan_status in ('fully paid','current') then 'good loan' when loan_status='charged off' then 'bad loan' end as `loan status`,
format(avg(annual_income),0) as `average annual income`, concat(round(avg(int_rate)*100,2),'%') as `average interest rate`, concat(round(avg(dti)*100,2),'%') as ` average debt to income`
from financial_loan
group by 
case when loan_status in ('fully paid', 'current') then 'good loan' when loan_status='charged off' then 'bad loan' end;

-- loan term
select term as `term`,  count(id) as `total loan application`, format(sum(loan_amount),0) as ` total funded amount`, format(sum(total_payment),0) as `total received amount`
from financial_loan group by term order by term;

-- loan purpose
select purpose as `loan purpose`, count(id) as `total loan application`, format(sum(loan_amount),0) as `total funded amount`, format(sum(total_payment),0) as `total received amount`
from financial_loan group by purpose order by purpose;

-- home ownership
select home_ownership as `home ownership`, count(id) as `total loan application`, format(sum(loan_amount),0) as `total funded amount`, format(sum(total_payment),0) as `total received amount`
from financial_loan group by home_ownership order by home_ownership;

-- employee length
select emp_length as `employee length`, count(id) as `total loan application`, format(sum(loan_amount),0) as `total funded amount`, format(sum(total_payment),0) as `total received amount`
from financial_loan group by emp_length order by emp_length;

-- regional by state
select address_state as `state`, count(id) as `total loan application`,format(sum(loan_amount),0) as `total funded amount`,format(sum(total_payment),0) as `total received amount`
from financial_loan group by address_state order by address_state;

-- monthly trend 
select month(str_to_date(issue_date,'%d/%m/%y')) as``,monthname(str_to_date(issue_date, '%d/%m/%y')) as `month`, count(id) as `total loan application`, format(sum(loan_amount),0) as `total funded amount`, format(sum(total_payment),0) as `total received amount`
from financial_loan group by monthname(str_to_date(issue_date, '%d/%m/%y')),month(str_to_date(issue_date,'%d/%m/%y')) order by month(str_to_date(issue_date,'%d/%m/%y'));

