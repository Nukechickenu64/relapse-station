// ~general blood related stuff
#define TOTAL_BLOOD_REQ_DEFAULT 224
#define ALBINO_BLOOD_REDUCTION 150

#define GET_EFFECTIVE_BLOOD_VOL(num, total_blood_req) (max(num - DEFAULT_TOTAL_BLOOD_REQ + total_blood_req, 0))

//Bloody shoe blood states
#define BLOOD_STATE_SHIT "shit"
