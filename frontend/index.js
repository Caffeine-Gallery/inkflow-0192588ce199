import { backend } from 'declarations/backend';

let quill;

document.addEventListener('DOMContentLoaded', async () => {
  quill = new Quill('#editor', {
    theme: 'snow'
  });

  const newPostBtn = document.getElementById('newPostBtn');
  const newPostForm = document.getElementById('newPostForm');
  const postForm = document.getElementById('postForm');
  const postsSection = document.getElementById('posts');

  newPostBtn.addEventListener('click', () => {
    newPostForm.style.display = 'block';
  });

  postForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const title = document.getElementById('title').value;
    const author = document.getElementById('author').value;
    const image = document.getElementById('image').value;
    const body = quill.root.innerHTML;

    try {
      await backend.createPost(title, body, author, image ? [image] : []);
      newPostForm.style.display = 'none';
      postForm.reset();
      quill.setContents([]);
      await displayPosts();
    } catch (error) {
      console.error('Error creating post:', error);
      alert('Failed to create post. Please try again.');
    }
  });

  await displayPosts();
});

async function displayPosts() {
  try {
    const posts = await backend.getPosts();
    const postsSection = document.getElementById('posts');
    postsSection.innerHTML = '';

    if (posts.length === 0) {
      postsSection.innerHTML = '<p>No posts available.</p>';
      return;
    }

    posts.forEach(post => {
      const article = document.createElement('article');
      article.innerHTML = `
        <h2>${post.title}</h2>
        <p class="author">By ${post.author}</p>
        ${post.image[0] ? `<img src="${post.image[0]}" alt="${post.title}" class="post-image">` : ''}
        <div class="content">${post.body}</div>
        <p class="timestamp">${new Date(Number(post.timestamp) / 1000000).toLocaleString()}</p>
      `;
      postsSection.appendChild(article);
    });
  } catch (error) {
    console.error('Error fetching posts:', error);
    const postsSection = document.getElementById('posts');
    postsSection.innerHTML = '<p>Failed to load posts. Please try again later.</p>';
  }
}
