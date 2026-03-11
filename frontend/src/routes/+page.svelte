<script lang="ts">
  import { goto } from '$app/navigation'; 

  let id = "";

  function searchProduct():  void {
    if (!id.trim()) return;

    goto(`/product/${id}`);
  }
</script>

<div class="min-h-screen w-full flex justify-center px-6 pt-[22vh]">
  <div class="w-full max-w-2xl flex flex-col items-center gap-8">
    <div class="flex flex-col items-center gap-3 text-center">
      <h1 class="text-6xl font-semibold tracking-tight text-primary">Veritas</h1>
      <p class="max-w-md text-sm leading-6 text-black/55">
        Track the history of a product through its Veritas ID.
      </p>
    </div>

    <div class="w-full rounded-2xl border border-primary/20 bg-white/80 p-2 shadow-sm">
      <div class="flex items-center">
        <input
          type="text"
	  bind:value={id}
          placeholder="Enter Veritas ID"
          class="h-12 flex-1 bg-transparent px-4 text-sm text-black placeholder:text-black/35 outline-none"
	  on:keydown={(e) => { (e.key === "Enter") ? searchProduct() : null }}
        />

        <button
          class="h-12 rounded-xl bg-primary px-5 text-sm font-medium text-white transition hover:opacity-90 cursor-pointer"
	  on:click={searchProduct}
        >
          Search
        </button>
      </div>
    </div>
  </div>
</div>
