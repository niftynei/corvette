<script>
import { lnsocket_init } from '../js/lnsocket.js';

//const NODE_ID = "02cca6c5c966fcf61d121e3a70e03a1cd9eeeea024b26ea666ce974d43b242e636";
//const WEBSOCKET_ADDR = "ws://45.55.129.100:9999";
//const RUNE = "rz7_2oyBbTsu-aOeU2-2QOu3J-ToskWKTB0HN66NLBo9MjUmbWV0aG9kXmxpc3R8bWV0aG9kXmdldHxtZXRob2Q9c3VtbWFyeSZtZXRob2QvbGlzdGRhdGFzdG9yZQ==";

let rune = "";
let node_id = "";
let connectstr = "";

async function make_request(method, rune, params) {
    const LNSocket = await lnsocket_init();
    if (LNSocket === undefined) {
        console.log("oh no");
        return;
    }
    const ln = LNSocket();

    ln.genkey();
    await ln.connect_and_init(node_id, connectstr);

    const id = "lnsocketdemo:1";
    const { result, error } = await ln.rpc({rune, method, params, id });
    ln.disconnect();
    return {result, error};
}

async function getinfo() {
    return await make_request("getinfo", rune, {});
}

let promise = getinfo();

function handleClick() {
    promise = getinfo();
}
</script>
<h1>Svelte to-do list</h1>

    <form>
        <label for="node_id">What's your node id?</label>
        <input bind:value={node_id} type="text" id="node_id" autocomplete="off" />
        <label for="node_id">What's your connection details?</label>
        <input bind:value={connectstr} type="text" id="connect" autocomplete="off" />
        <label for="node_id">Permission rune</label>
        <input bind:value={rune} type="text" id="rune" autocomplete="off" />
    </form>
    <button type="button" on:click={handleClick}>
        Get Info!
    </button>

{#await promise}
    <p> loading infos </p>
{:then infos}
    <p>node infos: {infos.result.id}</p>
{:catch error}
    <p style="color: red">{error}</p>
{/await}
