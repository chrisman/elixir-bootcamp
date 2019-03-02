import {Socket} from "phoenix"

let socket = new Socket("/socket", { params: { token: window.userToken } })

socket.connect()

const createSocket = (topicId) => {
  let channel = socket.channel(`comments:${topicId}`, {})

  channel
    .join()
    .receive("ok", resp => {console.log(resp); renderComments(resp)})
    .receive("error", console.error)

  channel.on(`comments:${topicId}:new`, renderComment)

  document.querySelector('button').addEventListener('click', () => {
    const content = document.querySelector('textarea').value;
    channel.push('comment:add', { content });
  })
}

const renderComment = ({ comment }) => {
  document.querySelector('.collection').innerHTML += commentTemplate(comment)
}

const renderComments = ({ comments }) => {
  document.querySelector('.collection').innerHTML = ''
  comments.forEach(comment => {
    renderComment({ comment })
  })
}

const commentTemplate = ({ content, user }) => `
  <li class="collection-item">
    ${content}
    <div class="secondary-content">
      ${ (user) ? user.email : 'Anonymous' }
    </div>
  </li>
`;

window.createSocket = createSocket;
