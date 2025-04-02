Return-Path: <linux-sctp+bounces-465-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF88A78FA1
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Apr 2025 15:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DF43B2973
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Apr 2025 13:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D4B23A99E;
	Wed,  2 Apr 2025 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg4pWlCc"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926E23A98E;
	Wed,  2 Apr 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600107; cv=none; b=caPbwCP8BPW2un9T+MEOmvSX916xQdw3KGl2FtpE4r+45ovjjQeNwkwl4Dt3xyBV7/yVb2iGEmoV7Sn9ctM2Ox8w+5eDTXnx17QMneT/29xIir1KzNeBLqWSkYow57B/qySrylmRiOJ+ctltpp0MdjP48tU9L83Gl6vvet8LNwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600107; c=relaxed/simple;
	bh=Aih92G9gvTghe7QDVHm0e4Bv2q0GnJ+JdVDu8fRsnKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAz0OAtXM5FjtV9PzEqUZqGsvQv2KeRa+FDPDazCA7cW7JkW1t79sdk6/rTQdU4lhcHsjN0p1OCudscm6RoBDxRTyPHBp+8VSG31/Z1rpjJ2f3B7dgkjL1+Oli4V2W0TXIx6PFdXA+HtW1DXuYCWGrPsSsb471z3NTpLE8HkhxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg4pWlCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E34C4CEDD;
	Wed,  2 Apr 2025 13:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743600106;
	bh=Aih92G9gvTghe7QDVHm0e4Bv2q0GnJ+JdVDu8fRsnKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fg4pWlCcQcP7HnsKGaDEbrkfkblDOGpTcbrlRJOnedb1q2+4v9SJQIRQTXmQCdTOg
	 VUTBigSa1YtEyYsWkGTCVTmKazYadFjIlT6RJOy8stdB2y4jBZwbd0dBJgiBI84ihI
	 65/0GmuValgKQrIMuPgxGpm5BKw8rDX0oyWriSYp0dmSSsobwV37E7b/FBe6I0/mZB
	 MikxeamJLxzwt62zQanPpeLf/v/vSxsFCjkcKmjlgaoY5+G7GNcDalvKndshnLiPem
	 qunmLPDMG0pAEJ5EnMeKAjXYLOhgMvD9i0RXyqisMPmiZqPhIPKeskTjwCLkTScIhv
	 3vri5mqzg9QfA==
Date: Wed, 2 Apr 2025 14:21:41 +0100
From: Simon Horman <horms@kernel.org>
To: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel-dev@igalia.com, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] sctp: check transport existence before processing a send
 primitive
Message-ID: <20250402132141.GO214849@horms.kernel.org>
References: <20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>

On Wed, Apr 02, 2025 at 12:25:36PM +0200, Ricardo Cañuelo Navarro wrote:
> sctp_sendmsg() re-uses associations and transports when possible by
> doing a lookup based on the socket endpoint and the message destination
> address, and then sctp_sendmsg_to_asoc() sets the selected transport in
> all the message chunks to be sent.
> 
> There's a possible race condition if another thread triggers the removal
> of that selected transport, for instance, by explicitly unbinding an
> address with setsockopt(SCTP_SOCKOPT_BINDX_REM), after the chunks have
> been set up and before the message is sent. This causes the access to
> the transport data in sctp_outq_select_transport(), when the association
> outqueue is flushed, to do a use-after-free read.
> 
> This patch addresses this scenario by checking if the transport still
> exists right after the chunks to be sent are set up to use it and before
> proceeding to sending them. If the transport was freed since it was
> found, the send is aborted. The reason to add the check here is that
> once the transport is assigned to the chunks, deleting that transport
> is safe, since it will also set chunk->transport to NULL in the affected
> chunks. This scenario is correctly handled already, see Fixes below.
> 
> The bug was found by a private syzbot instance (see the error report [1]
> and the C reproducer that triggers it [2]).
> 
> Link: https://people.igalia.com/rcn/kernel_logs/20250402__KASAN_slab-use-after-free_Read_in_sctp_outq_select_transport.txt [1]
> Link: https://people.igalia.com/rcn/kernel_logs/20250402__KASAN_slab-use-after-free_Read_in_sctp_outq_select_transport__repro.c [2]
> Cc: stable@vger.kernel.org
> Fixes: df132eff4638 ("sctp: clear the transport of some out_chunk_list chunks in sctp_assoc_rm_peer")
> Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
> ---
>  net/sctp/socket.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 36ee34f483d703ffcfe5ca9e6cc554fba24c75ef..9c5ff44fa73cae6a6a04790800cc33dfa08a8da9 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -1787,17 +1787,24 @@ static int sctp_sendmsg_check_sflags(struct sctp_association *asoc,
>  	return 1;
>  }
>  
> +static union sctp_addr *sctp_sendmsg_get_daddr(struct sock *sk,
> +					       const struct msghdr *msg,
> +					       struct sctp_cmsgs *cmsgs);
> +
>  static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
>  				struct msghdr *msg, size_t msg_len,
>  				struct sctp_transport *transport,
>  				struct sctp_sndrcvinfo *sinfo)
>  {
> +	struct sctp_transport *aux_transport = NULL;
>  	struct sock *sk = asoc->base.sk;
> +	struct sctp_endpoint *ep = sctp_sk(sk)->ep;
>  	struct sctp_sock *sp = sctp_sk(sk);
>  	struct net *net = sock_net(sk);
>  	struct sctp_datamsg *datamsg;
>  	bool wait_connect = false;
>  	struct sctp_chunk *chunk;
> +	union sctp_addr *daddr;
>  	long timeo;
>  	int err;
>  
> @@ -1869,6 +1876,15 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
>  		sctp_set_owner_w(chunk);
>  		chunk->transport = transport;
>  	}
> +	/* Fail if transport was deleted after lookup in sctp_sendmsg() */
> +	daddr = sctp_sendmsg_get_daddr(sk, msg, NULL);
> +	if (daddr) {
> +		sctp_endpoint_lookup_assoc(ep, daddr, &aux_transport);
> +		if (!aux_transport || aux_transport != transport) {
> +			sctp_datamsg_free(datamsg);
> +			goto err;

Hi Ricardo,

This is not a full review, and I would suggest waiting for one from others.
But this will result in the local variable err being used uninitialised.

Flagged by Smatch.

> +		}
> +	}
>  
>  	err = sctp_primitive_SEND(net, asoc, datamsg);
>  	if (err) {

-- 
pw-bot: changes-requested

