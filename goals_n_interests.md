# Goals and Interests

## Bill Boz

- Data Flow from Database to Frontend
- Writing plugs

## Kevin (Genius) Genus

- Team Auth (similar to User Authent and Authorize)
- real-time pages
  - dynamic updates
  - dynamic notification of updates (PubSub)

## Daniel Pinheiro

- Plug Flow
- How to see a server functioning (see understand data and flow)

## Bill Tihen

- user Authent and Authorize - page permissions on Static & liveview pages (say an admin page) and also for liveview sessions (actions?)
- composable queries
  - base query
  - optional joins
  - optional wheres
- Back fill data migrations (with data manipulations) - ie:
  - we add a new username field,
  - field is required
  - field is unique
  - field needs data - email without '@' & '.' (or some other data processing to backfill)
  - see; https://dashbit.co/blog/automatic-and-manual-ecto-migrations
  - https://elixirforum.com/t/how-to-use-ecto-in-a-mix-task-within-a-phoenix-project/47573 - mix task with app_start
