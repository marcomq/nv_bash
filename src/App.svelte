<script>
	import backend from "nimview"
	
	let currentItem = ""
	let history = []
	let hovering = false
	let mainInput

	const addItem = () => {
		history = history.filter(item => item.text !== currentItem)
		history.unshift({id: Math.max(0, ...history.map(t => t.id)) + 1, text: currentItem})
		history = history
		storeAll()
		mainInput.focus()
	}
	const deleteItem = (id) => {
		history = history.filter(item => item.id !== id)
		storeAll()
	}
	const clear = () => {
		history = []
		storeAll()
	}
	const storeAll = () => {
		backend.setStoredVal("history", JSON.stringify(history))
	}
	const run = () => {
		backend.spawnShell(currentItem)
		addItem()
	}
	const getAll = async () => {
		try {
			let jsonResponse = await backend.getStoredVal("history")
			history = JSON.parse(jsonResponse)
			if (history.length > 0) {
				currentItem = history[0].text
			}
		} 
		catch (e) {
			console.log(e)
		}
		mainInput.focus()
	}
	$: backend.waitInit().then(() => {getAll()})
</script>
<main>
	<nav class="navbar navbar-expand-lg navbar-dark bg-success ">
	<div class="container">
		<a class="navbar-brand" on:click|preventDefault href={"#"} >Run command in WSL / Bash</a>
	</div>
	</nav>
	<div class="container">
		<div class="row">
			<div class="col">
				<form on:submit|preventDefault={run}>
					<div class="input-group mainInput">
						<input type="text" class="form-control add-todo" bind:this={mainInput} bind:value="{currentItem}" placeholder="Add todo" />
						<div class="input-group-append">
							<button class="btn btn-outline-success" type="submit">Run</button>
						</div>
					</div>
				</form>
				{#if history.length > 0}
				<ul id="sortable" class="list-unstyled">
				{#each history as item}
					<li class="ui-state-default">		
						<a href={"#"} on:click|preventDefault={ () => deleteItem(item.id)} title="delete" class="delete">x</a>
						<a href={"#"} on:click|preventDefault={ () => {
							currentItem=item.text
						}}>
							{item.text}
						</a>
					</li>
				{/each}
				</ul>
				<div class="footer">
					<div class="float-left">
						<strong><span class="count-todos">{history.length}</span></strong>
						{#if history.length == 1}
						Entry
						{:else}
						Entries
						{/if}
					</div>
					<div class="float-right clear">
						<button id="clear" on:click={clear} class="btn btn-outline-success">clear</button>
					</div>
				</div>
				{/if}
			</div>
		</div>
	</div>
</main>
<style>
.row .col {
	max-width: 600px;
}
.mainInput {
	margin-top: 20px;
	margin-bottom: 20px;
}
.footer {
	padding-bottom: 45px;
}
ul li input, .count-todos{
    margin-right: 9px;
    margin-left: 3px;
}
.delete {
  position: relative;
  top: 1px;
  font-size: 20px;
  color: #A00;
  margin-right: 9px;
}
.is-active {
    background-color: #3273dc;
    color: #fff;
}
</style>