#  TODO's:

# Network
- NWPathMonitor to check for internet availability (Error accordingly)

# Errors:
- More robust Error handling (specifically HTTP Errors - 400/500 etc.)

# UI/UX
- Add Transitions/Animations
- UI needs some love. Works for this simple app, but will need refresh if going to the public.
- Debouncing for refresh to prevent user ability to make api calls on demand.

# Persistence
- caching location data is pii - needs encryption and should not use User Defaults for this in a production app.
