Return-Path: <linux-sctp+bounces-734-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCBEC2DEB4
	for <lists+linux-sctp@lfdr.de>; Mon, 03 Nov 2025 20:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE86C4E05BC
	for <lists+linux-sctp@lfdr.de>; Mon,  3 Nov 2025 19:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9781D31D372;
	Mon,  3 Nov 2025 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAdLwYPM"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE14310625
	for <linux-sctp@vger.kernel.org>; Mon,  3 Nov 2025 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198919; cv=none; b=HqkOwelAXV6LVV4WjwL+O5WMJ6YDJCrzJIcmB7M3wFk0gbEWtKgzbumqETxbf4ZEgX9M2/Z4QrcBZZ/CH4lXd+pkSGLmbeJJj6ApAHYHCbNus3jsD0lEYUpKREfQT8BNi0BU1plnyceDHrZG/aaj/sMOiw7gnyQa1fj4mm34CRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198919; c=relaxed/simple;
	bh=ytOAUmNRkyNrb+8SNM2LQjWX8qc1SfKmf5XVP7jIKcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw+P3W1ci82kOHvXHjqPoPqoseQE7577ibUbqiUFnern7L72fJMEIfRqPcpcss4vS86OOHtGYlx/rhP/qyONxVtfmxjxXKrLGdl5zD6Qa8cGRjOlt5EqURNcBCnbPMam921/dXtQ1WCv0b1yTBG1YOq7pWHcln3NVCLKj/Mg+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAdLwYPM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33292adb180so5229412a91.3
        for <linux-sctp@vger.kernel.org>; Mon, 03 Nov 2025 11:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762198917; x=1762803717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RbFOj80zs/7n03tE8N1wEZb2vM09ZvVsc7QoNx1ezY=;
        b=SAdLwYPMVlamNqGleD5GADzeZti3STqcp1hg3KPkwHcWqbWRmapVv1qUphJv4+chTe
         IsqapZOkAYB8wg/emd8YLxsHAyweMz+h0mfCLmgqUpjWw+x1qeAsEj9D6D2GxIbr6BYC
         s6fOmVFOdTpv7qYbBWR6uTXPB+sB6N8vcBnjgPIj8ilLW0McyHdtHwmY276gwBLvSfFM
         4KFow4Kqi3sGYcrnIRmzo0Gv08mjwMI7+8U/Wngr8xGgKte4EwbNkBZK7GlHJWv+8iW/
         6JnUH3wz/9dJhFTYD4eD57SNrKAqYIKC+rrqdLK+75G+8K5vduiHp8Ebc0i4qVnO/bTV
         qpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762198917; x=1762803717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RbFOj80zs/7n03tE8N1wEZb2vM09ZvVsc7QoNx1ezY=;
        b=akgD7+pN1qS4nQnIkr7ySozUd5Ke5+sH1hgRSv+j4URZ0UIyE0FVGcU04u8CtjZ5zp
         bQZqR4/YzmQizwL+SJTunTHZLVG9yWum7OOYjSXo7Q2cl/jsrYn4vrP6CH5MdQUjFAyP
         69Z3f2L3MEUYsG17M24wrkFNRbduxhE7ibtQfzUJlpPaqsjxyGRt1Jard34kPf49OlXw
         NMxQ24SlhK7amjdeFqLPiqeGriemwoiYRuKjTCYdoHbQbhLekMBIqxPTMquwXWWAbGG5
         3myggE+4R3GnY/HqBUlyUbGPPW2K+xNxl2zNSGR++N6DjG4tqKWoM3dRS5lxGm9Xs29l
         sNuw==
X-Forwarded-Encrypted: i=1; AJvYcCVIdN6o/kae0Nt9pz5oosPC0EYeg1NM0sMehjzNRrFNQPHKSuIXukQtrAuuMheCh5uyiVMCXieG3fs0@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZQmsncmd1miahG9jqruxQKTo2334/hTl1Fw8UqjfVUSLzsps
	GQO/5TPZuBOOrEOUC4KPPSKoUSyesAWDbPP3zjPT4eoPwXIvmEXBM+3STHBA1RX3nft+0ryPpip
	L+ZYT9AMBKH4uFymI2IZgQdGUTpKsBgI=
X-Gm-Gg: ASbGncvhxV2/oS8lTY/tPKWvttHVT/aNKPu3QjzbpICYi1OW0sPcTONmOyxLXvip9va
	Gp0qeD9Fc8TvW6NTGGXOivqxVlWawAinuQHOuWDhyWWHNGrumjtkFqr5MbJq+kC0hzGhzIQI9VM
	tz1Ld0gYaIuMcBKl9eA/vvw78jToIYJITZ4dwl4iRs6YqX9AxP6Oc6wJBqKpAPFWDgVjil/BXl5
	xNbu5wkArBE+1KetE0OJmEjG67RZrR7oVojvCwVzV2GqUH+fUFIABFWpB0iaSG0MPhJ3Yc=
X-Google-Smtp-Source: AGHT+IFF702hXzMq3F2a8uGm8E60svn1HEyf0oLw6pQ2hliT+hDxZq38YemBD8AMk5LJLMgs3f8KaJ09KIEXyWShNJM=
X-Received: by 2002:a17:90b:38d0:b0:341:25a:ad4 with SMTP id
 98e67ed59e1d1-341025a122fmr7788990a91.37.1762198917347; Mon, 03 Nov 2025
 11:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
In-Reply-To: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 3 Nov 2025 14:41:45 -0500
X-Gm-Features: AWmQ_bnY9CHWjDcwZC0Iq3uTXqVqXa1nB6j2AnO1OSN-u6hNqbFa3oymkdmy2U4
Message-ID: <CADvbK_cFoj7Y81dGTmBzY4BOyZrkdoSa37zkeavRy4gaMEKRwg@mail.gmail.com>
Subject: Re: [PATCH net v3 0/3] Fix SCTP diag locking issues
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 12:15=E2=80=AFPM Stefan Wiehler
<stefan.wiehler@nokia.com> wrote:
>
> - Hold RCU read lock while iterating over address list in
>   inet_diag_msg_sctpaddrs_fill()
> - Prevent TOCTOU out-of-bounds write
> - Hold sock lock while iterating over address list in sctp_sock_dump_one(=
)
>
> v3:
> - Elaborate on TOCTOU call path
> - Merge 3 patches into series
> v2:
> - Add changelog and credit, release sock lock in ENOMEM error path:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20251027102541.232=
0627-2-stefan.wiehler@nokia.com/
> - Add changelog and credit:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20251027101328.231=
2025-2-stefan.wiehler@nokia.com/
> v1:
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251023191807.740=
06-2-stefan.wiehler@nokia.com/
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251027084835.225=
7860-1-stefan.wiehler@nokia.com/
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251027085007.225=
9265-1-stefan.wiehler@nokia.com/
>
> Stefan Wiehler (3):
>   sctp: Hold RCU read lock while iterating over address list
>   sctp: Prevent TOCTOU out-of-bounds write
>   sctp: Hold sock lock while iterating over address list
>
Series
Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks.

