# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Cleaning database..."
ShiftAssignment.destroy_all
Employee.destroy_all
Shift.destroy_all
Department.destroy_all

puts "Creating departments..."
it_dept = Department.create!(
  name: "IT Department",
  description: "Information Technology and Software Development"
)

hr_dept = Department.create!(
  name: "Human Resources",
  description: "Employee Relations and Recruitment"
)

ops_dept = Department.create!(
  name: "Operations",
  description: "Business Operations and Management"
)

sales_dept = Department.create!(
  name: "Sales",
  description: "Sales and Customer Relations"
)

puts "Creating employees..."
emp1 = Employee.create!(
  name: "Ahmet Yılmaz",
  email: "ahmet.yilmaz@example.com",
  phone: "+90 555 111 2233",
  role: "manager",
  department: it_dept
)

emp2 = Employee.create!(
  name: "Ayşe Demir",
  email: "ayse.demir@example.com",
  phone: "+90 555 222 3344",
  role: "employee",
  department: it_dept
)

emp3 = Employee.create!(
  name: "Mehmet Kaya",
  email: "mehmet.kaya@example.com",
  phone: "+90 555 333 4455",
  role: "supervisor",
  department: hr_dept
)

emp4 = Employee.create!(
  name: "Fatma Şahin",
  email: "fatma.sahin@example.com",
  phone: "+90 555 444 5566",
  role: "employee",
  department: ops_dept
)

emp5 = Employee.create!(
  name: "Ali Özkan",
  email: "ali.ozkan@example.com",
  phone: "+90 555 555 6677",
  role: "employee",
  department: sales_dept
)

emp6 = Employee.create!(
  name: "Zeynep Arslan",
  email: "zeynep.arslan@example.com",
  phone: "+90 555 666 7788",
  role: "manager",
  department: ops_dept
)

puts "Creating shifts..."
morning_shift = Shift.create!(
  name: "Morning Shift",
  start_time: "08:00",
  end_time: "16:00",
  description: "Regular morning shift from 8 AM to 4 PM"
)

evening_shift = Shift.create!(
  name: "Evening Shift",
  start_time: "16:00",
  end_time: "23:59",
  description: "Evening shift from 4 PM to midnight"
)

night_shift = Shift.create!(
  name: "Night Shift",
  start_time: "00:00",
  end_time: "07:59",
  description: "Night shift from midnight to 8 AM"
)

afternoon_shift = Shift.create!(
  name: "Afternoon Shift",
  start_time: "12:00",
  end_time: "20:00",
  description: "Afternoon shift from noon to 8 PM"
)

puts "Creating shift assignments..."
# Today and next 7 days
today = Date.today

# Morning shift assignments
ShiftAssignment.create!(
  employee: emp1,
  shift: morning_shift,
  date: today,
  status: "scheduled"
)

ShiftAssignment.create!(
  employee: emp2,
  shift: morning_shift,
  date: today + 1.day,
  status: "scheduled"
)

# Evening shift assignments
ShiftAssignment.create!(
  employee: emp3,
  shift: evening_shift,
  date: today,
  status: "scheduled"
)

ShiftAssignment.create!(
  employee: emp4,
  shift: evening_shift,
  date: today + 1.day,
  status: "scheduled"
)

# Night shift assignments
ShiftAssignment.create!(
  employee: emp5,
  shift: night_shift,
  date: today,
  status: "scheduled"
)

ShiftAssignment.create!(
  employee: emp6,
  shift: night_shift,
  date: today + 1.day,
  status: "completed"
)

# Afternoon shift assignments
ShiftAssignment.create!(
  employee: emp1,
  shift: afternoon_shift,
  date: today + 2.days,
  status: "scheduled"
)

ShiftAssignment.create!(
  employee: emp3,
  shift: afternoon_shift,
  date: today + 3.days,
  status: "scheduled"
)

puts "Seed data created successfully!"
puts "#{Department.count} departments"
puts "#{Employee.count} employees"
puts "#{Shift.count} shifts"
puts "#{ShiftAssignment.count} shift assignments"
