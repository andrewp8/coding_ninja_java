var ctx = document.getElementById('myChart').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        datasets: [{
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
});

// Get the current date
var today = new Date();

// Get the year and month of the current date
var year = today.getFullYear();
var month = today.getMonth();

// Create a new date object for the first day of the current month
var firstDay = new Date(year, month, 1);

// Get the number of days in the current month
var numDays = new Date(year, month + 1, 0).getDate();

// Create an array to hold the names of the days of the week
var weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

// Create a table element to display the calendar
var table = "<table><thead><tr>";

// Add the weekday names to the table header
for (var i = 0; i < weekdays.length; i++) {
  table += "<th>" + weekdays[i] + "</th>";
}

table += "</tr></thead><tbody>";

// Add blank cells for any days before the first day of the month
for (var i = 0; i < firstDay.getDay(); i++) {
  table += "<td></td>";
}

// Add cells for each day of the month
for (var i = 1; i <= numDays; i++) {
  // If this is the first day of a new week, start a new row
  if (i === 1 || (i - 1 + firstDay.getDay()) % 7 === 0) {
    table += "<tr>";
  }

  // Add a cell for the current day
  table += "<td>" + i + "</td>";

  // If this is the last day of a week, end the row
  if (i === numDays || (i - 1 + firstDay.getDay()) % 7 === 6) {
    table += "</tr>";
  }
}

table += "</tbody></table>";

// Insert the table into the HTML page
document.getElementById("calendar").innerHTML = table;