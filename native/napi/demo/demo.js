const UNM = require("..");

const ctx = { enableFlac: true };

async function main() {
  UNM.enableLogging(UNM.LoggingType.ConsoleEnv);
  const executor = new UNM.Executor();
  
  console.log(`Enabled engines: ${executor.list().join(", ")}`);
  const searchResult = await executor.search(
    executor.list(),
    {
      id: "12345",
      name: "青花瓷",
      artists: [
        {
          id: "114514",
          name: "周杰伦",
        },
      ],
    },
    ctx
  );
  console.log(searchResult);

  const retrieveResult = await executor.retrieve(searchResult, ctx);
  console.log(retrieveResult);
}

main();
