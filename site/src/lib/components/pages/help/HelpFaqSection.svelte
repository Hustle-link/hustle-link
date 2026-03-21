<script lang="ts">
	import { HelpCircle } from '@lucide/svelte';
	import { motion } from 'motion-sv';
	import { cubicOut } from 'svelte/easing';
	import { fade, fly, scale } from 'svelte/transition';
	import type { FaqCategory } from './help.types';

	interface Props {
		filteredFaqs: FaqCategory[];
	}

	let { filteredFaqs }: Props = $props();
</script>

<section id="faqs" class="bg-white py-20 md:py-24 lg:py-28">
	<div class="mx-auto w-full max-w-5xl px-6">
		<div in:fade={{ duration: 420 }} class="mb-16 text-center">
			<h2 class="font-space-grotesk mb-4 text-5xl font-bold text-[#0F172A]">
				Frequently Asked Questions
			</h2>
			<p class="mx-auto max-w-2xl text-lg text-gray-600">
				Browse curated answers for the most common HustleLink questions.
			</p>
		</div>

		{#if filteredFaqs.length === 0}
			<div
				in:scale={{ duration: 260, start: 0.97 }}
				class="rounded-3xl border border-dashed border-slate-300 bg-slate-50 px-8 py-12 text-center"
			>
				<HelpCircle class="mx-auto mb-4 text-[#00E676]" size={36} />
				<h3 class="font-space-grotesk mb-2 text-2xl font-bold text-[#0F172A]">No results found</h3>
				<p class="mx-auto max-w-xl text-gray-600">
					Try a different search term or contact support if you still need help with your issue.
				</p>
			</div>
		{:else}
			<div class="space-y-14">
				{#each filteredFaqs as category, categoryIndex (category.category)}
					<div in:fly={{ y: 28, duration: 460, delay: categoryIndex * 90, easing: cubicOut }}>
						<div class="mb-6 flex items-center gap-3">
							<div
								class="flex h-10 w-10 items-center justify-center rounded-xl bg-[#00E676] text-white"
							>
								<category.icon size={20} />
							</div>
							<h3 class="font-space-grotesk text-3xl font-bold text-[#0F172A]">
								{category.category}
							</h3>
						</div>

						<div class="space-y-5">
							{#each category.questions as item, questionIndex (`${category.category}-${item.q}`)}
								<motion.div
									initial={{ opacity: 0, y: 16 }}
									animate={{ opacity: 1, y: 0 }}
									transition={{ delay: questionIndex * 0.06, duration: 0.28 }}
								>
									<details
										class="group rounded-2xl border border-gray-200 bg-white p-6 transition-colors hover:border-[#00E676] md:p-7"
									>
										<summary class="flex cursor-pointer list-none items-start gap-4 md:gap-5">
											<HelpCircle class="mt-1 shrink-0 text-[#00E676]" size={20} />
											<div class="flex-1">
												<h4
													class="font-space-grotesk text-lg font-bold text-[#0F172A] transition-colors group-hover:text-[#00E676]"
												>
													{item.q}
												</h4>
											</div>
										</summary>
										<div class="mt-5 pl-9 leading-relaxed text-gray-600 md:pl-10">{item.a}</div>
									</details>
								</motion.div>
							{/each}
						</div>
					</div>
				{/each}
			</div>
		{/if}
	</div>
</section>
