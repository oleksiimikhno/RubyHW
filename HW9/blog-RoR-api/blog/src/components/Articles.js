import React, { useState, useEffect } from 'react'

import './articles.scss';

const urlAPI = 'http://localhost:3000/api/v1/articles'

const getData = () => fetch(urlAPI).then(response => response.json());

function Articles() {
  const [articles, setArticles] = useState([]);

  useEffect(() => {
    getData().then(items => setArticles(items));
  }, []);

  const renderItems = (array) => {
    const items = array.map((item) => {
      return (
        <article key={item.id}>
          <h1>{item.title}</h1>
          <p>{item.body}</p>
          
          <button>x</button>
        </article>
      )
    });

    return (
      <div>
        {items}
      </div>
    )
  }

  const articlesList = renderItems(articles)

  return (
    <>
      <h1>Articles</h1>
      {articlesList}
    </>
  )
}

export default Articles