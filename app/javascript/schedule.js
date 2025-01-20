document.addEventListener('DOMContentLoaded', function() {
  const scheduleGrid = document.getElementById('schedule-grid');
  
  scheduleGrid.addEventListener('click', function(event) {
    if (event.target.classList.contains('time-slot') && event.target.closest('.technician-column')) {
      const clickedColumn = event.target.closest('.technician-column');
      const clickedTimeSlot = event.target;
  
      // Get the clicked hour and minutes from the time slot
      const timeText = clickedTimeSlot.textContent.trim();
      // const [clickedHour, clickedMinutes] = timeText.split(':').map(Number);
      // const clickedMinutesSinceStart = clickedHour * 60 + (clickedMinutes || 0);

      const clickedHour = clickedTimeSlot.dataset.hour;
      const clickedMinutesSinceStart = clickedHour * 60;
  
      // Collect all work orders for the selected technician
      const workOrders = [...clickedColumn.querySelectorAll('.work-order')].map(workOrder => {
        return {
          startTime: parseInt(workOrder.dataset.startMinutes, 10),
          duration: parseInt(workOrder.dataset.duration, 10)
        };
      });
  
      // Sort work orders by start time
      workOrders.sort((a, b) => a.startTime - b.startTime);
  
      let availableTime = 0;
      let slotFound = false;
  
      for (let i = 0; i <= workOrders.length; i++) {
        let previousEnd = i > 0 ? workOrders[i - 1].startTime + workOrders[i - 1].duration : 0;
        let nextStart = i < workOrders.length ? workOrders[i].startTime : 24 * 60; // End of day
  
        // console.log(previousEnd);
        // console.log(nextStart);

        if (clickedMinutesSinceStart >= previousEnd && clickedMinutesSinceStart < nextStart) {
          // Calculate available time between current click position and the next work order
          availableTime = nextStart - previousEnd;
          slotFound = true;
        }
      }
  
      if (slotFound) {
        let availableHours = Math.floor(availableTime / 60);
        let availableMinutes = availableTime % 60;
        alert(`Available Time: ${availableHours} hour(s) and ${availableMinutes} minute(s).`);
      } else {
        alert("No available time slot found.");
      }
    }
  });  
});
