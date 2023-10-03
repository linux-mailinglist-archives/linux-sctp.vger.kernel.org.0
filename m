Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFFF7B6970
	for <lists+linux-sctp@lfdr.de>; Tue,  3 Oct 2023 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjJCMvn (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 3 Oct 2023 08:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjJCMvn (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 3 Oct 2023 08:51:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B155683;
        Tue,  3 Oct 2023 05:51:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1895BC433C8;
        Tue,  3 Oct 2023 12:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696337500;
        bh=giCCL/NQzyaXSepsEpVlfuBXyhXS1M2eW5ebS85qKZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rz4WfdlKsXh1tFMotFawMYFAsYy2FjqKasOSSRBu5y6Yk6xxZUt7oaPH/+FfMAXll
         xw207CQd/qaXVdVNBPqnp+u3U/jhAMUB+31upo1GUynANt3cOzOX4VlJpjunymCOiA
         bgWi+0exsrfd1Wh6EDX3xJzXxZ+B4PU5vblYXaG94i7URiI9Smqex+9+YTqXAEULI+
         i5G9QD10CdKbMjRN22No7aBUoZEaTWNgHB0NkkeYRbSB3NNo6b+HilmgzhUJYVCGfz
         oOQPKxmyfTZhHJMRJmr8Lh4tw0m7FCcVxPMe7A9c5qZAMLqY/boJFiGnDAbDVcc4e+
         zVWQGxcBPSdaw==
Date:   Tue, 3 Oct 2023 14:51:35 +0200
From:   Simon Horman <horms@kernel.org>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH nf] netfilter: handle the connecting collision properly
 in nf_conntrack_proto_sctp
Message-ID: <ZRwOVyKQR8MBjpBh@kernel.org>
References: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sun, Oct 01, 2023 at 11:07:48AM -0400, Xin Long wrote:

...

> @@ -481,6 +486,24 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
>  			    old_state == SCTP_CONNTRACK_CLOSED &&
>  			    nf_ct_is_confirmed(ct))
>  				ignore = true;
> +		} else if (sch->type == SCTP_CID_INIT_ACK) {
> +			struct sctp_inithdr _ih, *ih;
> +			u32 vtag;
> +
> +			ih = skb_header_pointer(skb, offset + sizeof(_sch), sizeof(*ih), &_ih);
> +			if (ih == NULL)
> +				goto out_unlock;
> +
> +			vtag = ct->proto.sctp.vtag[!dir];
> +			if (!ct->proto.sctp.init[!dir] && vtag && vtag != ih->init_tag)
> +				goto out_unlock;
> +			/* collision */
> +			if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir] &&
> +			    vtag != ih->init_tag)

The type of vtag is u32. But the type of ct->proto.sctp.vtag[!dir] and init_tag
is __be32. This doesn't seem right (and makes Sparse unhappy).

> +				goto out_unlock;
> +
> +			pr_debug("Setting vtag %x for dir %d\n", ih->init_tag, !dir);
> +			ct->proto.sctp.vtag[!dir] = ih->init_tag;
>  		}
>  
>  		ct->proto.sctp.state = new_state;
> -- 
> 2.39.1
> 
> 
