$(document).ready(function() {
    $('#hourForm').on('submit', function(e) {
        e.preventDefault();

        const attendanceIn = $('#attendanceIn').val();
        const attendanceOut = $('#attendanceOut').val();

        const concepts = [
            {
                "id": "HO",
                "name": "HO",
                "start": "08:00",
                "end": "17:59"
            },
            {
                "id": "HED",
                "name": "HED",
                "start": "18:00",
                "end": "20:59"
            },
            {
                "id": "HEN",
                "name": "HEN",
                "start": "21:00",
                "end": "05:59"
            }
        ];

        const data = {
            attendanceIn: attendanceIn,
            attendanceOut: attendanceOut,
            concepts: concepts
        };

        $.ajax({
            url: 'https://falconcloud.co/site_srv10_ph/site/api/qserv.php/13465-770721',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function(response) {
                displayChart(response);
            },
            error: function(error) {
                console.error('Error:', error);
            }
        });
    });

    function displayChart(data) {
        const ctx = document.getElementById('hourChart').getContext('2d');
        const labels = Object.keys(data);
        const values = Object.values(data);

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Horas Trabajadas',
                    data: values,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }
});