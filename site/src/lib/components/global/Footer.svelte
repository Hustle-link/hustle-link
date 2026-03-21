<script lang="ts">
	import { motion } from 'motion-sv';
	import { Zap } from '@lucide/svelte';
	import { resolve } from '$app/paths';

	const circles = Array.from({ length: 30 }, (_, i) => ({ delay: i * 0.1 }));
	const lines = Array.from({ length: 15 }, (_, i) => ({ delay: i * 0.2 }));
</script>

<!-- TODO: add links to social media profiles -->
<footer
	id="footer"
	data-nav-theme="dark"
	class="relative overflow-hidden bg-[#0F172A] py-20 text-white"
>
	<!-- Network Effect Background -->
	<div class="absolute inset-0 opacity-10">
		<svg class="h-full w-full">
			{#each circles as circle, i (`circle-${i}`)}
				<motion.circle
					cx={`${(i * 7) % 100}%`}
					cy={`${(i * 13) % 100}%`}
					r="2"
					fill="#00E676"
					animate={{ opacity: [0.3, 1, 0.3] }}
					transition={{ duration: 3, delay: circle.delay, repeat: Infinity }}
				/>
			{/each}

			<!-- Connection Lines -->
			{#each lines as line, i (`line-${i}`)}
				<motion.line
					x1={`${(i * 11) % 100}%`}
					y1={`${(i * 7) % 100}%`}
					x2={`${((i + 1) * 11) % 100}%`}
					y2={`${((i + 1) * 7) % 100}%`}
					stroke="#00E676"
					stroke-width="0.5"
					animate={{ opacity: [0.1, 0.5, 0.1] }}
					transition={{ duration: 4, delay: line.delay, repeat: Infinity }}
				/>
			{/each}
		</svg>
	</div>

	<div class="relative z-10 mx-auto max-w-7xl px-6">
		<!-- CTA Section -->
		<div class="mb-20 text-center">
			<motion.h2
				class="font-space-grotesk mb-6 text-5xl font-bold md:text-6xl"
				initial={{ opacity: 0, y: 30 }}
				animate={{ opacity: 1, y: 0 }}
				transition={{ duration: 0.6 }}
			>
				Looking to grow <span class="text-[#00E676]">your team?</span>
			</motion.h2>

			<motion.p
				class="mb-10 text-xl text-gray-300"
				initial={{ opacity: 0, y: 20 }}
				animate={{ opacity: 1, y: 0 }}
				transition={{ delay: 0.2, duration: 0.6 }}
			>
				Connect with Botswana's top talent and build your dream team
			</motion.p>

			<motion.a
				class="font-space-grotesk inline-block rounded-full bg-[#00E676] px-10 py-5 text-lg font-bold text-[#0F172A]"
				href={resolve(...(['/contact'] as unknown as Parameters<typeof resolve>))}
				initial={{ opacity: 0, y: 20 }}
				animate={{ opacity: 1, y: 0 }}
				transition={{ delay: 0.4, duration: 0.6 }}
				whileHover={{ scale: 1.05 }}
				whilePress={{ scale: 0.95 }}
			>
				Contact Team
			</motion.a>
		</div>

		<!-- Footer Links -->
		<div class="mb-16 grid gap-12 md:grid-cols-4">
			<div>
				<div class="mb-6 flex items-center gap-3">
					<div class="flex h-10 w-10 items-center justify-center rounded-lg bg-[#00E676]">
						<Zap class="text-[#0F172A]" size={24} />
					</div>
					<span class="font-space-grotesk text-2xl font-bold"> HustleLink </span>
				</div>
				<p class="text-gray-400">
					Connecting Botswana's finest talent with opportunities that matter.
				</p>
			</div>

			<div>
				<h4 class="font-space-grotesk mb-4 font-bold">Company</h4>
				<ul class="space-y-2 text-gray-400">
					<li>
						<a
							href={resolve(...(['/'] as unknown as Parameters<typeof resolve>))}
							class="transition-colors hover:text-[#00E676]"
						>
							Home
						</a>
					</li>
					<li>
						<a
							href={resolve(...(['/about'] as unknown as Parameters<typeof resolve>))}
							class="transition-colors hover:text-[#00E676]"
						>
							About Us
						</a>
					</li>
					<li>
						<a
							href={resolve(...(['/download'] as unknown as Parameters<typeof resolve>))}
							class="transition-colors hover:text-[#00E676]"
						>
							Download App
						</a>
					</li>
				</ul>
			</div>

			<div>
				<h4 class="font-space-grotesk mb-4 font-bold">Resources</h4>
				<ul class="space-y-2 text-gray-400">
					<li>
						<a
							href={resolve(...(['/help'] as unknown as Parameters<typeof resolve>))}
							class="transition-colors hover:text-[#00E676]"
						>
							Help Center
						</a>
					</li>
					<li>
						<a
							href={resolve(...(['/demo'] as unknown as Parameters<typeof resolve>))}
							class="transition-colors hover:text-[#00E676]"
						>
							Demo
						</a>
					</li>
					<li>
						<a
							href={resolve(...(['/contact'] as unknown as Parameters<typeof resolve>))}
							class="transition-colors hover:text-[#00E676]"
						>
							Support Contact
						</a>
					</li>
				</ul>
			</div>

			<div>
				<h4 class="font-space-grotesk mb-4 font-bold">Support</h4>
				<ul class="space-y-2 text-gray-400">
					<li>
						<a
							href={resolve(...(['/contact'] as unknown as Parameters<typeof resolve>))}
							class="transition-colors hover:text-[#00E676]"
						>
							Contact
						</a>
					</li>
					<li>
						<a
							href={resolve(...(['/help'] as unknown as Parameters<typeof resolve>))}
							class="transition-colors hover:text-[#00E676]"
						>
							FAQs
						</a>
					</li>
					<li>
						<a
							href={resolve(...(['/privacy-security'] as unknown as Parameters<typeof resolve>))}
							class="transition-colors hover:text-[#00E676]"
						>
							Privacy & Security
						</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="border-t border-gray-800 pt-8 text-center text-gray-400">
			<p>Copyright 2026 HustleLink BW. Built for the Future.</p>
		</div>
	</div>
</footer>
