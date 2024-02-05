clear

import excel "C:\Users\Steven Sun\Desktop\9thGame\data4.xlsx", sheet("Sheet1") firstrow
gen zipcode_n = real(zipcode)
gen timen = date(time1,"YMD")
gen cover = total / population * 100
gen L_pt = L_pos

// do first-stage 2sls by hand
reghdfe share_black dis, cluster(cluster)
// get the filtered share_black
gen fblack = dis * -.2714479 + 22.54092

// do second-stage 2sls by hand
reghdfe cover L_pos fblack mean_age, absorb(time) cluster(cluster)

// we find the weak IV problem 
ivreg2 cover (share_black=dis) L_pos, cluster(cluster)