function formatDate_ssm(time, years, mouths, dates, hours, miuntes, secounts) {
    var flag = /^\d+$/.test(time);
    if (flag) {
        time = new Date(time / 1000)
    }
    try{
        return formatDates_ssm(time, years, mouths, dates, hours, miuntes, secounts)
    }catch (e){
        console.log(e)
    }
   
}

function formatDates_ssm(now, years, mouths, dates, hours, minutes, seconds) {
    var year = now.getFullYear();
    var month = now.getMonth() + 1;
    var date = now.getDate();
    var hour = now.getHours();
    var minute = now.getMinutes();
    var second = now.getSeconds();
    var result
    if (years != undefined) {
        result = year + years;
    }
    if (mouths != undefined) {
        result = result + month + mouths;
    }
    if (dates != undefined) {
        result = result + date + dates
    }
    if (hours != undefined) {
        result = result + hour + hours
    }
    if (minutes != undefined) {
        result = result + minute + minutes
    }
    if (seconds != undefined) {
        result = result + second + seconds
    }
    return result;
}