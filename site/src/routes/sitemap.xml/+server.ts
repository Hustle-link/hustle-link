import type { RequestHandler } from './$types';

type SitemapEntry = {
	path: string;
	changefreq: 'daily' | 'weekly' | 'monthly';
	priority: string;
};

const pages: SitemapEntry[] = [
	{ path: '/', changefreq: 'daily', priority: '1.0' },
	{ path: '/about', changefreq: 'monthly', priority: '0.8' },
	{ path: '/contact', changefreq: 'monthly', priority: '0.8' },
	{ path: '/help', changefreq: 'weekly', priority: '0.8' },
	{ path: '/download', changefreq: 'weekly', priority: '0.9' },
	{ path: '/privacy-security', changefreq: 'monthly', priority: '0.7' },
	{ path: '/demo', changefreq: 'monthly', priority: '0.4' }
];

export const GET: RequestHandler = ({ url }) => {
	const origin = url.origin;
	const lastmod = new Date().toISOString();

	const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${pages
	.map(
		(entry) => `  <url>
    <loc>${origin}${entry.path}</loc>
    <lastmod>${lastmod}</lastmod>
    <changefreq>${entry.changefreq}</changefreq>
    <priority>${entry.priority}</priority>
  </url>`
	)
	.join('\n')}
</urlset>`;

	return new Response(xml, {
		headers: {
			'Content-Type': 'application/xml; charset=utf-8',
			'Cache-Control': 'max-age=0, s-maxage=3600'
		}
	});
};
