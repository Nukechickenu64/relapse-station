#define SCREENTIP_OPENSPACE(name) "<span style='text-align: center;font-family: \"Small Fonts\";font-size:12px;-dm-text-outline: 2px black;color: #305a42'>[name]</span>"
#define SCREENTIP_TURF(name) "<span style='text-align: center;font-family: \"Small Fonts\";font-size:12px;-dm-text-outline: 2px black;color: #3a9260'>[name]</span>"
#define SCREENTIP_OBJ(name) "<span style='text-align: center;font-family: \"Small Fonts\";font-size:12px;-dm-text-outline: 2px black;color: #6DC595'>[name]</span>"
#define SCREENTIP_MOB(name) "<span style='text-align: center;font-family: \"Small Fonts\";font-size:12px;-dm-text-outline: 2px black;color: #8BDFDE'>[name]</span>"

// ~screentip flags
#define SCREENTIP_ON_MOUSE_ENTERED (1<<0)
#define SCREENTIP_ON_MOUSE_MOVE (1<<1)
#define SCREENTIP_ON_MOUSE_CLICK (1<<2)

#define DEFAULT_SCREENTIP_FLAGS (SCREENTIP_ON_MOUSE_ENTERED)
#define SCREENTIP_HOVERER (SCREENTIP_ON_MOUSE_ENTERED | SCREENTIP_ON_MOUSE_MOVE)
#define SCREENTIP_HOVERER_CLICKER (SCREENTIP_ON_MOUSE_ENTERED | SCREENTIP_ON_MOUSE_MOVE | SCREENTIP_ON_MOUSE_CLICK)
#define SCREENTIP_CLICKER (SCREENTIP_ON_MOUSE_ENTERED | SCREENTIP_ON_MOUSE_CLICK)
