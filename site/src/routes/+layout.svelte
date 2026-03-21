<script lang="ts">
	import './layout.css';
	import Footer from '$lib/components/global/Footer.svelte';
	import NavBar from '$lib/components/global/NavBar.svelte';
	import PageSeo from '$lib/components/global/PageSeo.svelte';

	let { children } = $props();
</script>

<PageSeo />

<NavBar />
{@render children()}
<Footer />
