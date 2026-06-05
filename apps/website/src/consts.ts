export const SITE_TITLE = 'Tinycord';
export const SITE_DESCRIPTION = 'A secure and lightweight alternative to the official Discord client.';

export const pageUrl = (path: string) => {
  const base = import.meta.env.BASE_URL;
  return `${base.replace(/\/$/, '')}${path}`;
};
